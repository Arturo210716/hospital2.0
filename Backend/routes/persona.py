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

@persona.get('/personas/{id_persona}')
def get_persona(id_persona: int):
    global personas
    
    # Buscar la persona por su ID
    for persona in personas:
        if persona.id == id_persona:
            return persona

    return f"No existe alguna persona con ese id: {id_persona} "

@persona.post('/personas')

def save_persona(datos_persona:model_personas):
    personas.append(datos_persona)
    return "Datos guardados correctamente"


@persona.delete('/personas/{id_persona}')

def delete_persona(id_persona: int):
    global personas
    
    # Buscar la persona por su ID
    for i, persona in enumerate(personas):
        if persona.id == id_persona:
            del personas[i]
            return f"Dato con ID {id_persona} eliminado correctamente."
    return f"No existe alguna persona con ese id: {id_persona} "

@persona.put('/personas/{id_persona}')
def update_persona(id_persona: int, datos_persona: model_personas):
    global personas
    
    # Buscar la persona por su ID
    for persona in personas:
        if persona.id == id_persona:
            # Actualizar los campos de la persona
            persona.nombre = datos_persona.nombre
            persona.primer_apellido = datos_persona.primer_apellido
            persona.segundo_apellido = datos_persona.segundo_apellido
            persona.edad = datos_persona.edad
            persona.fecha_nacimiento = datos_persona.fecha_nacimiento
            persona.curp = datos_persona.curp
            persona.tipo_sangre = datos_persona.tipo_sangre
            
            
            return f"Dato con ID {id_persona} actualizado correctamente."
    return f"No existe alguna persona con ese id: {id_persona} "

