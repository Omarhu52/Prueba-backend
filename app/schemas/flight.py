from pydantic import BaseModel
from datetime import datetime

class FlightBase(BaseModel):
    airline: str
    origin_city: str
    destination_city: str
    departure_time: datetime
    arrival_time: datetime
    price: float
    seat_category: str
    available_seats: int
    status: str

class FlightOut(FlightBase):
    id: int

    class Config:
        orm_mode = True
