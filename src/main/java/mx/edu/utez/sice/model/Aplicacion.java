package mx.edu.utez.sice.model;

import java.util.ArrayList;

public class Aplicacion {
    private int id_aplicacion;
    private int id_periodo;
    private int id_examen;
    //ArrayList para la tabla respuesta_opcion
    private ArrayList<Integer> respuesta_opcion;

    public Aplicacion() {
    }

    public Aplicacion(int id_aplicacion, int id_periodo, int examen_id_examen) {
        this.id_aplicacion = id_aplicacion;
        this.id_periodo = id_periodo;
        this.id_examen = examen_id_examen;
    }

    public int getId_aplicacion() {
        return id_aplicacion;
    }

    public void setId_aplicacion(int id_aplicacion) {
        this.id_aplicacion = id_aplicacion;
    }

    public int getId_periodo() {
        return id_periodo;
    }

    public void setId_periodo(int id_periodo) {
        this.id_periodo = id_periodo;
    }

    public int getId_examen() {
        return id_examen;
    }

    public void setId_examen(int id_examen) {
        this.id_examen = id_examen;
    }

    public ArrayList<Integer> getRespuesta_opcion() {
        return respuesta_opcion;
    }

    public void setRespuesta_opcion(ArrayList<Integer> respuesta_opcion) {
        this.respuesta_opcion = respuesta_opcion;
    }
}
