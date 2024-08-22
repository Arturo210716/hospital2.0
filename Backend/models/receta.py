#from sqlalchemy import Column,Integer,String,Boolean,DateTime,ForeignKey
from sqlalchemy.dialects.mysql import LONGTEXT
from sqlalchemy.orm import relationship
#from config.db import Base

from sqlalchemy import Column, Integer, String, DateTime
from config.db import Base

class Receta(Base):
    __tablename__ = "tbd_recetaMedica"
    
    ID = Column(Integer, primary_key=True, index=True)
    Nombre = Column(String(255), nullable=False)
    Fecha_Nacimiento = Column(DateTime, nullable=False)
    Peso = Column(String(20), nullable=False) 
    Talla = Column(String(20), nullable=False)
    Edad = Column(String(20), nullable=False)
    Presion_arterial = Column(String(20), nullable=False)
    Diagnostico = Column(String(255), nullable=False)
    Prescripcion_Medica = Column(String(255), nullable=False)  # Cambiado a String(255) si esperas más texto
    Fecha_Registro = Column(DateTime, nullable=False)
    Fecha_Actualizacion = Column(DateTime, nullable=True)
