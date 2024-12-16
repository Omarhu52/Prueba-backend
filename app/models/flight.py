from sqlalchemy import Column, Integer, String, Float, TIMESTAMP
from app.db.session import Base
from sqlalchemy.orm import relationship

class Flight(Base):
    __tablename__ = "flights"

    id = Column(Integer, primary_key=True, index=True)
    airline = Column(String, nullable=False)
    origin_city = Column(String, nullable=False)
    destination_city = Column(String, nullable=False)
    departure_time = Column(TIMESTAMP, nullable=False)
    arrival_time = Column(TIMESTAMP, nullable=False)
    price = Column(Float, nullable=False)
    seat_category = Column(String, nullable=False)
    available_seats = Column(Integer, nullable=False)
    status = Column(String, default="on time", nullable=False)

    reservations = relationship("Reservation", back_populates="flight")
