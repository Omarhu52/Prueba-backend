from pydantic import BaseModel, EmailStr

class UserLogin(BaseModel):
    email: EmailStr
    password: str

class UserBase(BaseModel):
    email: EmailStr
    credit_card: str | None = None  

class UserCreate(UserBase):
    password: str  

class UserOut(UserBase):
    id: int

    class Config:
        orm_mode = True
