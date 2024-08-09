package mx.edu.utez.sice.model;

public class Carrera {
    private int id_carrera;
    private String carrera;
    private int id_division_academica;

    public Carrera() {
    }

    public Carrera(int id_carrera, String carrera, int id_division_academica) {
        this.id_carrera = id_carrera;
        this.carrera = carrera;
        this.id_division_academica = id_division_academica;
    }

    public int getId_carrera() {
        return id_carrera;
    }

    public void setId_carrera(int id_carrera) {
        this.id_carrera = id_carrera;
    }

    public String getCarrera() {
        return carrera;
    }

    public void setCarrera(String carrera) {
        this.carrera = carrera;
    }

    public int getId_division_academica() {
        return id_division_academica;
    }

    public void setId_division_academica(int id_division_academica) {
        this.id_division_academica = id_division_academica;
    }
}
