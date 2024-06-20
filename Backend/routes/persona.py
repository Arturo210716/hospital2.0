from fastapi import APIRouter
from pydantic import BaseModel
from datetime import datetime
from typing import Optional

persona = APIRouter()
personas=[]

class model_personas(BaseModel):
    id:int
    nombre:str
    primer_apellido:str
    segundo_apellido:Optional[str]
    edad:int
    fecha_nacimiento: datetime
    curp: str
    tipo_sangre: str
    created_at: datetime = datetime.now()
    estatus: bool = False


@persona.get('/')

def bienvenido():
    return "Bienvenido al api del sistema"

@persona.get('/personas')

def getPersonas():
    return personas

@persona.post('/personas')

def save_persona(datos_persona:model_personas):
    personas.append(datos_persona)
    return "Datos guardados correctamente"