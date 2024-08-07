from typing import List,Union
from pydantic import BaseModel
from datetime import datetime

from models.persons import MyGenero, MySangre

class ExpedienteBase(BaseModel):
    
    Titulo_Cortesia:str
    Nombre: str
    Primer_Apellido: str
    Segundo_Apellido: str
    Curp: str
    Genero: MyGenero
    Tipo_Sangre:  MySangre  
    Fecha_Nacimiento: datetime
    Fotografia:str
    Telefono: str
    Correo_Electronico: str
    Estatus:bool
    Fecha_Registro:datetime
    Fecha_Actualizacion:datetime


    
    
class ExpedienteCreate(ExpedienteBase):
    pass
class ExpedienteUpdate(ExpedienteBase):
    pass
class Expediente(ExpedienteBase):
    ID: int

    class Config:
        orm_mode = True