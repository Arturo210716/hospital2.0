from fastapi import APIRouter,HTTPException,Depends,Request
from sqlalchemy.orm import Session
from portadortoken import Portador
import crud.persons,config.db,schemas.persons,models.persons
from typing import List
from sqlalchemy import func


person = APIRouter()

models.persons.Base.metadata.create_all(bind=config.db.engine)

def get_db():
    db = config.db.SessionLocal()
    try:
        yield db
    finally:
        db.close()
        
@person.get("/persons/", response_model=List[schemas.persons.Person], tags=["Personas"] ,dependencies=[Depends(Portador())])
def read_persons(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    db_persons= crud.persons.get_persons(db=db, skip=skip, limit=limit)
    return db_persons

@person.post("/person/{ID}", response_model=schemas.persons.Person, tags=["Personas"] ,dependencies=[Depends(Portador())])
def read_person(ID: int, db: Session = Depends(get_db)):
    db_person= crud.persons.get_person(db=db, ID=ID)
    if db_person is None:
        raise HTTPException(status_code=404, detail="Person not found")
    return db_person

@person.post("/persons/", response_model=schemas.persons.Person, tags=["Personas"])
def create_person(person: schemas.persons.PersonCreate, db: Session = Depends(get_db)):
    db_person = crud.persons.get_person_by_Nombre(db, Nombre=person.Nombre)
    if db_person:
        raise HTTPException(status_code=400, detail="Persona existente intenta nuevamente")
    return crud.persons.create_person(db=db, person=person)

@person.put("/person/{ID}", response_model=schemas.persons.Person, tags=["Personas"] ,dependencies=[Depends(Portador())])
def update_person(ID: int, person: schemas.persons.PersonUpdate, db: Session = Depends(get_db)):
    db_person = crud.persons.update_person(db = db, ID = ID, person = person)
    if db_person is None:
        raise HTTPException(status_code=404, detail="Persona no existente, no esta actuaizado")
    return db_person

@person.delete("/person/{ID}", response_model=schemas.persons.Person, tags=["Personas"] ,dependencies=[Depends(Portador())])
def delete_person(ID: int, db: Session = Depends(get_db)):
    db_person = crud.persons.delete_person(db = db, ID = ID)
    if db_person is None:
        raise HTTPException(status_code=404, detail="Persona no existe, no se pudo eliminar")
    return db_person

""" @person.get("/persons/datos", tags=["Personas"])
def get_personas_data(db: Session = Depends(get_db)):
    generos = db.query(
        models.persons.Genero,
        func.count(models.persons.Genero).label('cantidad')
    ).group_by(models.persons.Genero).all()

    tipo_sangre = db.query(
        models.persons.MySangre,
        func.count(models.persons.MySangre).label('cantidad')
    ).group_by(models.persons.MySangre).all()

    genero_data = {'Masculino': 0, 'Femenino': 0, 'Otro': 0}
    tipo_sangre_data = {'ap': 0, 'an': 0, 'bp': 0, 'bn': 0, 'abp': 0, 'abn': 0, 'op': 0, 'on': 0}

    for genero in generos:
        genero_data[genero.Genero.lower()] = genero.cantidad

    for sangre in tipo_sangre:
        tipo_sangre_data[sangre.Tipo_Sangre.lower()] = sangre.cantidad

    return {
        "genero": genero_data,
        "tipo_sangre": tipo_sangre_data
    } """
