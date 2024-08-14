package mx.edu.utez.sice.model;

public class DivisionAcademica {
    private int id_division_academica;
    private String nombre_division_academica;

    public DivisionAcademica(int id_division_academica, String nombre_division_academica) {
        this.id_division_academica = id_division_academica;
        this.nombre_division_academica = nombre_division_academica;
    }

    public  DivisionAcademica (){}

    public int getId_division_academica() {
        return id_division_academica;
    }

    public void setId_division_academica(int id_division_academica) {
        this.id_division_academica = id_division_academica;
    }

    public String getDivision_academica() {
        return nombre_division_academica;
    }

    public void setDivision_academica(String nombre_division_academica) {
        this.nombre_division_academica = nombre_division_academica;
    }
}
