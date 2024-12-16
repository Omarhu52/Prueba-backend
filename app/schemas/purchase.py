from pydantic import BaseModel
from datetime import datetime

class PurchaseBase(BaseModel):
    reservation_id: int
    #credit_card: str

class PurchaseCreate(BaseModel):
    reservation_id: int
    credit_card: str

class PurchaseOut(PurchaseBase):
    id: int
    user_id: int
    payment_status: str
    purchase_date: datetime
    total_amount: float

    class Config:
        orm_mode = True
