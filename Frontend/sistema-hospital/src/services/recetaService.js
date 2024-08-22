import api from '../api';
import axios from 'axios';

const API_URL = 'http://localhost:8000/receta/'; 

export async function getRecetas() {
  const response = await api.get('/receta/');
  return response.data;
}

export async function getReceta(ID) {
  const response = await api.post(`/receta/${ID}`);
  return response.data;
}

export const createReceta = (receta) => {
    return axios.post(API_URL, receta);
  };

export async function updateReceta(ID, receta) {
  const response = await api.put(`/receta/${ID}`, receta);
  return response.data;
}

export async function deleteReceta(ID) {
  const response = await api.delete(`/receta/${ID}`);
  return response.data;
}



