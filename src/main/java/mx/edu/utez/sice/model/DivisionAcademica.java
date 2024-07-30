package mx.edu.utez.sice.model;

public class DivisionAcademica {
    private int id_division_academica;
    private String division_academica;

    public DivisionAcademica(int id_division_academica, String division_academica) {
        this.id_division_academica = id_division_academica;
        this.division_academica = division_academica;
    }

    public int getId_division_academica() {
        return id_division_academica;
    }

    public void setId_division_academica(int id_division_academica) {
        this.id_division_academica = id_division_academica;
    }

    public String getDivision_academica() {
        return division_academica;
    }

    public void setDivision_academica(String division_academica) {
        this.division_academica = division_academica;
    }
}
