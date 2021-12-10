from fastapi import FastAPI, Depends, status, Response, HTTPException
from sqlalchemy.orm import Session, synonym
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


@app.post("/user", status_code=status.HTTP_201_CREATED)
def create_user(request: schemas.User,db :Session = Depends(get_db)):
    new_user =models.User(name=request.name,email=request.email,password=request.password)
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return new_user

@app.get("/user")
def read_user_list(db :Session = Depends(get_db)):
    users = db.query(models.User).all()
    return users

@app.get("/user/{id}")
def read_user(id, db :Session = Depends(get_db)):
    user = db.query(models.User).filter(models.User.id == id).first()
    if not user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
        detail=f"User with the id {id} is not available"
        )
    return user

@app.put("/user/{id}", status_code=status.HTTP_202_ACCEPTED)
def update_user(id, request: schemas.User,db :Session = Depends(get_db)):
    db.query(models.User).filter(models.User.id == id).update(request.__dict__)
    db.commit()
    return 'done'

@app.delete("/user/{id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_user(id, db :Session = Depends(get_db)):
    db.query(models.User).filter(models.User.id == id).delete(synchronize_session=False)
    db.commit()
    return f"User with id {id} is deleted"
