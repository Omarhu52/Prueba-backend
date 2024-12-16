from sqlalchemy import Column, Integer, String, Float, ForeignKey, TIMESTAMP
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.db.session import Base

class Reservation(Base):
    __tablename__ = "reservations"

    id = Column(Integer, primary_key=True, index=True)
    flight_id = Column(Integer, ForeignKey("flights.id"), nullable=False)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    reservation_date = Column(TIMESTAMP, server_default=func.now())
    seats_reserved = Column(Integer, nullable=False)
    total_price = Column(Float, nullable=False)
    status = Column(String, default="confirmed")

    flight = relationship("Flight", back_populates="reservations")
    user = relationship("User", back_populates="reservations")
    purchases = relationship("Purchase", back_populates="reservation")
