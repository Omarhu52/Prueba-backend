from sqlalchemy import Column, Integer, String, Float, ForeignKey, TIMESTAMP
from sqlalchemy.orm import relationship
from app.db.session import Base
from datetime import datetime

class Purchase(Base):
    __tablename__ = "purchases"

    id = Column(Integer, primary_key=True, index=True)
    reservation_id = Column(Integer, ForeignKey("reservations.id"), nullable=False)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    payment_method = Column(String, nullable=False)
    payment_status = Column(String, default="pending")
    purchase_date = Column(TIMESTAMP, default=datetime.now)
    total_amount = Column(Float, nullable=False)

    reservation = relationship("Reservation", back_populates="purchases")
    user = relationship("User", back_populates="purchases")
