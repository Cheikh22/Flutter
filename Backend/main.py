from fastapi import FastAPI ,Depends
from sqlalchemy import engine
from sqlalchemy.orm import Session
import schemas
from database import engine , SessionLocal
import models

models.Base.metadata.create_all(engine)

app = FastAPI()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get("/")
def root():
    return {"message": "Hello World"}
    
@app.post("/user")
def create_user(request: schemas.User,db :Session = Depends(get_db)):
    new_user =models.User(name=request.name,email=request.email,password=request.password)
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return new_user

@app.get("/user/{id}")
def read_user(id: int):
    return f"read user with id {id}"

@app.put("/user/{id}")
def update_user(id: int):
    return f"update user with id {id}"

@app.delete("/user/{id}")
def delete_user(id: int):
    return f"delete user with id {id}"

@app.get("/user")
def read_user_list():
    return "read userlist"