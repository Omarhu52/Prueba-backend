from fastapi import FastAPI
from app.routes import auth, flight, reservation, purchase
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()


app = FastAPI(
    title="Flight Reservation System",
    description="API para gestionar reservas de vuelos.",
    version="1.0.0",
)

app.include_router(auth.router, prefix="/auth", tags=["auth"])
app.include_router(flight.router, prefix="/flights", tags=["flights"])
app.include_router(reservation.router, prefix="/reservations", tags=["reservations"])
app.include_router(purchase.router, prefix="/purchase", tags=["Purchases"])


app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:4200"],  
    allow_credentials=True,
    allow_methods=["*"],  
    allow_headers=["*"],  
)
@app.get("/")
def root():
    return {"message": "Welcome to the Flight Reservation System"}
