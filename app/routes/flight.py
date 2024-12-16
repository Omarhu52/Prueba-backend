from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.db.session import SessionLocal
from app.models.flight import Flight
from app.schemas.flight import FlightOut
from datetime import datetime
from typing import Optional

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.get("/flights/schedule", response_model=list[FlightOut])
def get_flights_by_schedule(db: Session = Depends(get_db)):
    flights = db.query(Flight).order_by(Flight.departure_time).all()
    return flights

@router.get("/flights/prices", response_model=list[FlightOut])
def get_flights_by_price(db: Session = Depends(get_db)):
    flights = db.query(Flight).order_by(Flight.price).all()
    return flights

@router.get("/flights/status", response_model=list[FlightOut])
def get_flights_by_status(
    flight_date: Optional[datetime] = None,
    origin: Optional[str] = None,
    destination: Optional[str] = None,
    airline: Optional[str] = None,
    seat_category: Optional[str] = None,
    db: Session = Depends(get_db)
):
    query = db.query(Flight)

    if flight_date:
        query = query.filter(
            Flight.departure_time >= flight_date,
            Flight.departure_time < flight_date.replace(hour=23, minute=59, second=59)
        )
    if origin:
        query = query.filter(Flight.origin_city == origin)
    if destination:
        query = query.filter(Flight.destination_city == destination)
    if airline:
        query = query.filter(Flight.airline == airline)
    if seat_category:
        query = query.filter(Flight.seat_category == seat_category)

    return query.all()


@router.get("/flights/origins", response_model=list[str])
def get_origin_cities(db: Session = Depends(get_db)):
    origins = db.query(Flight.origin_city).distinct().all()
    return [origin[0] for origin in origins]

@router.get("/flights/destinations", response_model=list[str])
def get_destination_cities(db: Session = Depends(get_db)):
    destinations = db.query(Flight.destination_city).distinct().all()
    return [destination[0] for destination in destinations]

@router.get("/flights/airlines", response_model=list[str])
def get_airlines(db: Session = Depends(get_db)):
    airlines = db.query(Flight.airline).distinct().all()
    return [airline[0] for airline in airlines]

@router.get("/flights/categories", response_model=list[str])
def get_seat_categories(db: Session = Depends(get_db)):
    categories = db.query(Flight.seat_category).distinct().all()
    return [category[0] for category in categories]

@router.get("/flights/dates", response_model=list[str])
def get_available_dates(db: Session = Depends(get_db)):
    dates = db.query(Flight.departure_time).distinct().all()
    return sorted(list({str(date[0].date()) for date in dates}))


