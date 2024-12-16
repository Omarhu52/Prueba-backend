from sqlalchemy.orm import Session
from app.models.reservation import Reservation
from app.schemas.reservation import ReservationCreate

def create_reservation(db: Session, reservation: ReservationCreate):
    db_reservation = Reservation(**reservation.dict())
    db.add(db_reservation)
    db.commit()
    db.refresh(db_reservation)
    return db_reservation
