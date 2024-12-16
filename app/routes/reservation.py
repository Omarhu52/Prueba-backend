from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.db.session import SessionLocal
from app.models.reservation import Reservation
from app.models.flight import Flight
from app.schemas.reservation import ReservationCreate, ReservationOut
from app.models.user import User
from datetime import datetime


router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/", response_model=ReservationOut)
def create_reservation(
    reservation: ReservationCreate,
    user_id: int, 
    db: Session = Depends(get_db)
):
    flight = db.query(Flight).filter(Flight.id == reservation.flight_id).first()
    if not flight:
        raise HTTPException(status_code=404, detail="Flight not found")

    if reservation.seats_reserved > flight.available_seats:
        raise HTTPException(status_code=400, detail="Not enough seats available")

    total_price = reservation.seats_reserved * flight.price

    new_reservation = Reservation(
    flight_id=reservation.flight_id,
    user_id=user_id,
    seats_reserved=reservation.seats_reserved,
    total_price=total_price,
    reservation_date=datetime.now(),  
)
    db.add(new_reservation)

    flight.available_seats -= reservation.seats_reserved

    db.commit()
    db.refresh(new_reservation)

    return new_reservation
