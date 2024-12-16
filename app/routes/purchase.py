from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.db.session import SessionLocal
from app.models.purchase import Purchase
from app.models.reservation import Reservation
from app.schemas.reservation import ReservationOut  
from app.schemas.purchase import PurchaseCreate, PurchaseOut

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.get("/user-reservations", response_model=list[ReservationOut])
def get_user_reservations(user_id: int, db: Session = Depends(get_db)):
    reservations = db.query(Reservation).filter(Reservation.user_id == user_id).all()
    return reservations

@router.post("/purchase", response_model=PurchaseOut)
def create_purchase(purchase: PurchaseCreate, db: Session = Depends(get_db)):
    reservation = db.query(Reservation).filter(Reservation.id == purchase.reservation_id).first()
    if not reservation:
        raise HTTPException(status_code=404, detail="Reservation not found")

    if reservation.status == "purchased":
        raise HTTPException(status_code=400, detail="Reservation already purchased")

    new_purchase = Purchase(
        reservation_id=purchase.reservation_id,
        user_id=reservation.user_id,
        payment_method="credit_card",  
        total_amount=reservation.total_price,
    )
    db.add(new_purchase)

    reservation.status = "purchased"

    db.commit()
    db.refresh(new_purchase)

    return new_purchase




