
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessiomaker

SQL_ALCHEMY_DATABASE_URL = "mysql+pymysql://root:1234@localhost:3307/test"
engine = create_engine(SQL_ALCHEMY_DATABASE_URL)
SessionLocal = sessiomaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()
