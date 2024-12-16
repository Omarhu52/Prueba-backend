from pydantic import BaseModel
from datetime import datetime
from typing import Optional

class ReservationBase(BaseModel):
    flight_id: int
    seats_reserved: int

class ReservationCreate(ReservationBase):
    pass

class ReservationOut(ReservationBase):
    id: int
    user_id: int
    reservation_date: Optional[datetime] = None 
    total_price: float
    status: str

    class Config:
        orm_mode = True
