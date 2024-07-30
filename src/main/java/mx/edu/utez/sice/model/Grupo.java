package mx.edu.utez.sice.model;

import java.util.ArrayList;

public class Grupo {

    private int id_grupo;
    private int grado;
    private char grupo;
    private int id_periodo;
    private ArrayList<Usuario> alumnos;

    public Grupo(int id_grupo, int grado, char grupo, int id_periodo, ArrayList<Usuario> alumnos) {
        this.id_grupo = id_grupo;
        this.grado = grado;
        this.grupo = grupo;
        this.id_periodo = id_periodo;
        this.alumnos = alumnos;
    }

    public int getId_grupo() {
        return id_grupo;
    }

    public void setId_grupo(int id_grupo) {
        this.id_grupo = id_grupo;
    }

    public int getGrado() {
        return grado;
    }

    public void setGrado(int grado) {
        this.grado = grado;
    }

    public char getGrupo() {
        return grupo;
    }

    public void setGrupo(char grupo) {
        this.grupo = grupo;
    }

    public int getId_periodo() {
        return id_periodo;
    }

    public void setId_periodo(int id_periodo) {
        this.id_periodo = id_periodo;
    }

    public ArrayList<Usuario> getAlumnos() {
        return alumnos;
    }

    public void setAlumnos(ArrayList<Usuario> alumnos) {
        this.alumnos = alumnos;
    }
}
