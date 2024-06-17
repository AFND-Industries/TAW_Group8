package com.example.GymWebAppSpring.entity;

import com.example.GymWebAppSpring.dto.DTO;
import com.example.GymWebAppSpring.dto.SesionentrenamientoDTO;
import jakarta.persistence.*;

@Entity
@Table(name = "sesionentrenamiento")
public class Sesionentrenamiento  implements DTO<SesionentrenamientoDTO> {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    private Integer id;

    @Column(name = "NOMBRE", nullable = false, length = 32)
    private String nombre;

    @Column(name = "DESCRIPCION", nullable = false, length = 256)
    private String descripcion;

    @Column(name = "DIA", nullable = false)
    private Integer dia;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "RUTINA", nullable = false)
    private Rutina rutina;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Integer getDia() {
        return dia;
    }

    public void setDia(Integer dia) {
        this.dia = dia;
    }

    public Rutina getRutina() {
        return rutina;
    }

    public void setRutina(Rutina rutina) {
        this.rutina = rutina;
    }

    @Override
    public SesionentrenamientoDTO toDTO() {
        SesionentrenamientoDTO sesionentrenamientoDTO = new SesionentrenamientoDTO();
        sesionentrenamientoDTO.setId(id);
        sesionentrenamientoDTO.setNombre(nombre);
        sesionentrenamientoDTO.setDescripcion(descripcion);
        sesionentrenamientoDTO.setDia(dia);
        sesionentrenamientoDTO.setRutina(rutina.toDTO());
        return sesionentrenamientoDTO;
    }
}