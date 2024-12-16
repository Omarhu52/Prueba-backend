from sqlalchemy import Column, Integer, String
from app.db.session import Base
from sqlalchemy.orm import relationship

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True)
    hashed_password = Column(String)
    credit_card = Column(String, nullable=True)

    reservations = relationship("Reservation", back_populates="user")
    purchases = relationship("Purchase", back_populates="user")