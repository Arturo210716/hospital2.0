from fastapi import APIRouter,HTTPException,Depends,Request
from sqlalchemy.orm import Session
import crud.receta
import models.receta
from portadortoken import Portador
import crud.receta,config.db,schemas.receta,models.receta
from typing import List

import schemas.receta

person = APIRouter()

models.receta.Base.metadata.create_all(bind=config.db.engine)

def get_db():
    db = config.db.SessionLocal()
    try:
        yield db
    finally:
        db.close()
        
@person.get("/receta/", response_model=List[schemas.receta.Receta], tags=["RecetaMedica"] ,dependencies=[Depends(Portador())])
def read_persons(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    db_receta= crud.receta.get_receta(db=db, skip=skip, limit=limit)
    return db_receta

@person.post("/receta/{ID}", response_model=schemas.receta.Receta, tags=["RecetaMedica"] ,dependencies=[Depends(Portador())])
def read_person(ID: int, db: Session = Depends(get_db)):
    db_receta= crud.persons.get_person(db=db, ID=ID)
    if db_receta is None:
        raise HTTPException(status_code=404, detail="Person not found")
    return db_receta

@person.post("/receta/", response_model=schemas.receta.Receta, tags=["RecetaMedica"])
def create_person(person: schemas.persons.PersonCreate, db: Session = Depends(get_db)):
    db_receta = crud.persons.get_person_by_Nombre(db, Nombre=person.Nombre)
    if db_receta:
        raise HTTPException(status_code=400, detail="Persona existente intenta nuevamente")
    return crud.persons.create_person(db=db, person=person)

@person.put("/receta/{ID}", response_model=schemas.receta.Receta, tags=["RecetaMedica"] ,dependencies=[Depends(Portador())])
def update_person(ID: int, person: schemas.receta.RecetaUpdate, db: Session = Depends(get_db)):
    db_receta = crud.persons.update_person(db = db, ID = ID, person = person)
    if db_receta is None:
        raise HTTPException(status_code=404, detail="Persona no existente, no esta actuaizado")
    return db_receta

@person.delete("/receta/{ID}", response_model=schemas.receta.Receta, tags=["RecetaMedica"] ,dependencies=[Depends(Portador())])
def delete_person(ID: int, db: Session = Depends(get_db)):
    db_receta = crud.persons.delete_person(db = db, ID = ID)
    if db_receta is None:
        raise HTTPException(status_code=404, detail="Persona no existe, no se pudo eliminar")
    return db_receta