package mx.edu.utez.sice.model;

import java.util.ArrayList;

public class Examen {
    private int id_examen;
    private String nombre_examen;
    private int cantidad_preguntas;
    private int estado;
    private String descripcion;
    private int id_usuario;
    //ArrayList para la tabla examen_tiene_pregunta
    private ArrayList<Integer> preguntas;

    public Examen() {}

    public Examen(int id_examen, String nombre_examen, int cantidad_preguntas, int estado, String descripcion, int id_usuario, ArrayList<Integer> preguntas) {
        this.id_examen = id_examen;
        this.nombre_examen = nombre_examen;
        this.cantidad_preguntas = cantidad_preguntas;
        this.estado = estado;
        this.descripcion = descripcion;
        this.id_usuario = id_usuario;
        this.preguntas = preguntas;
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

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public ArrayList<Integer> getPreguntas() {
        return preguntas;
    }

    public void setPreguntas(ArrayList<Integer> preguntas) {
        this.preguntas = preguntas;
    }

    // agregacion de Piero

    public void setId(int id) {
    }

    public void setNombre(String nombre) {
    }

    public void setGrado(String grado) {
    }

    public void setGrupo(String grupo) {
    }

    public void setDivision(String division) {
    }

    public void setCarrera(String carrera) {
    }

    public Object getNombreExamen() {
        return null;
    }
}
