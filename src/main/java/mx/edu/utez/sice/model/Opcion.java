package mx.edu.utez.sice.model;

import java.util.ArrayList;

public class Opcion {
    private int id_opcion;
    private String opcion;

    public Opcion() {
    }

    public Opcion(int id_opcion, String opcion) {
        this.id_opcion = id_opcion;
        this.opcion = opcion;
    }

    public int getId_opcion() {
        return id_opcion;
    }

    public void setId_opcion(int id_opcion) {
        this.id_opcion = id_opcion;
    }

    public String getOpcion() {
        return opcion;
    }

    public void setOpcion(String opcion) {
        this.opcion = opcion;
    }

    //Agregue esto aunque se lo tengo que quitar
    /*public int getId_pregunta() {
        return id_opcion;
    }*/
}
