package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.Carrera;
import mx.edu.utez.sice.model.DivisionAcademica;
import mx.edu.utez.sice.model.Grupo;
import mx.edu.utez.sice.model.Tabla;
import mx.edu.utez.sice.utils.DatabaseConnectionManager;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class GrupoEspecificoDao {

    public ArrayList<Tabla> getGrupoEspecifico(int grado, String grupo, int id_division, int id_carrera) throws SQLException {
        ArrayList<Tabla> tablas = new ArrayList<>();
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            String query = "{call obtener_grupo_especifico(?,?,?,?)}";
            CallableStatement cs = con.prepareCall(query);
            cs.setInt(1, grado);
            cs.setString(2, grupo);
            cs.setInt(3, id_division);
            cs.setInt(4, id_carrera);
            ResultSet rs = cs.executeQuery();

            while (rs.next()) {
                Tabla tabla = new Tabla();
                Carrera carrera = new Carrera();
                Grupo grupoObj = new Grupo();
                DivisionAcademica division = new DivisionAcademica();

                grupoObj.setId_grupo(rs.getInt("id_grupo"));
                grupoObj.setGrado(rs.getInt("grado"));
                grupoObj.setGrupo(rs.getString("grupo"));
                tabla.setGrupo(grupoObj);

                carrera.setCarrera(rs.getString("nombre_carrera"));
                tabla.setCarrera(carrera);

                division.setDivision_academica(rs.getString("nombre_division_academica"));
                tabla.setDivisionAcademica(division);

                tablas.add(tabla);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tablas;
    }
}