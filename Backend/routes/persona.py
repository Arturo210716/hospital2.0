from fastapi import APIRouter

persona = APIRouter()

@persona.get("/personas")

def helloWord():
    return "Hello World"