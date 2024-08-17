package mx.edu.utez.sice.model;

public class Tabla {

    private Grupo grupo;
    private DivisionAcademica division;
    private Carrera carrera;

    public Tabla(Grupo grupo, DivisionAcademica division, Carrera carrera) {
        this.grupo = grupo;
        this.division = division;
        this.carrera = carrera;
    }

    public Tabla() {
    }

    public Grupo getGrupo() {
        return grupo;
    }

    public void setGrupo(Grupo grupo) {
        this.grupo = grupo;
    }


    public DivisionAcademica getDivision() {
        return division;
    }

    public void setDivision(DivisionAcademica division) {
        this.division = division;
    }

    public Carrera getCarrera() {
        return carrera;
    }

    public void setCarrera(Carrera carrera) {
        this.carrera = carrera;
    }
}