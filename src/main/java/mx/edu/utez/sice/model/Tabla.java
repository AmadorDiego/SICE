package mx.edu.utez.sice.model;

public class Tabla {

    private Grupo grupo;
    private DivisionAcademica divisionAcademica; //Cambie division por division academica
    private Carrera carrera;
    private Usuario usuario;

    public Tabla(Grupo grupo, DivisionAcademica divisionAcademica, Carrera carrera, Usuario usuario) {
        this.grupo = grupo;
        this.divisionAcademica = divisionAcademica;
        this.carrera = carrera;
        this.usuario = usuario;
    }

    public Tabla() {
    }

    public Grupo getGrupo() {
        return grupo;
    }

    public void setGrupo(Grupo grupo) {
        this.grupo = grupo;
    }

    public DivisionAcademica getDivisionAcademica() {
        return divisionAcademica;
    }

    public void setDivisionAcademica(DivisionAcademica divisionAcademica) {
        this.divisionAcademica = divisionAcademica;
    }

    public Carrera getCarrera() {
        return carrera;
    }

    public void setCarrera(Carrera carrera) {
        this.carrera = carrera;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public void add(Tabla tabla) {
    }
}