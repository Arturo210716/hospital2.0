from fastapi import FastAPI
from routes.persons import person
from routes.users import user


app=FastAPI(
    title="Hospital General PrivilegeCare",
    description="API para el almacenamiento de informacipn de un hospital"
)

app.include_router(person)
app.include_router(user)
print("Bienvenido a mi aplicacion")