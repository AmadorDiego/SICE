package mx.edu.utez.sice.model;

import java.util.ArrayList;

public class Examen {
    private int id_examen;
    private String nombre_examen;
    private int cantidad_preguntas;
    private String descripcion;
    //ArrayList para la tabla examen_tiene_pregunta
    private ArrayList<Integer> preguntas;
    //ArrayList para la tabla usuario_tiene_examen
    private ArrayList<Integer> usuarios;

    public Examen() {}

    public Examen(int id_examen, String nombre_examen, int cantidad_preguntas, String descripcion, ArrayList<Integer> preguntas, ArrayList<Integer> usuarios) {
        this.id_examen = id_examen;
        this.nombre_examen = nombre_examen;
        this.cantidad_preguntas = cantidad_preguntas;
        this.descripcion = descripcion;
        this.preguntas = preguntas;
        this.usuarios = usuarios;
    }

    public int getId_examen() {
        return id_examen;
    }

    public void setId_examen(int id_examen) {
        this.id_examen = id_examen;
    }

    public String getNombre_examen() {
        return nombre_examen;
    }

    public void setNombre_examen(String nombre_examen) {
        this.nombre_examen = nombre_examen;
    }

    public int getCantidad_preguntas() {
        return cantidad_preguntas;
    }

    public void setCantidad_preguntas(int cantidad_preguntas) {
        this.cantidad_preguntas = cantidad_preguntas;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public ArrayList<Integer> getPreguntas() { return preguntas; }

    public void setPreguntas(ArrayList<Integer> preguntas) {
        this.preguntas = preguntas;
    }

    public ArrayList<Integer> getUsuarios() {
        return usuarios;
    }

    public void setUsuarios(ArrayList<Integer> usuarios) {
        this.usuarios = usuarios;
    }
}
