<template>
  <div class="charts-container">
    <div class="chart">
      <canvas id="generoChart" width="400" height="400"></canvas>
    </div>
    <div class="chart">
      <canvas id="tipoSangreChart" width="400" height="400"></canvas>
    </div>
  </div>
</template>

<style scoped>
/* Contenedor para los gráficos */
.charts-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 16px;
  padding: 16px;
}

/* Cada gráfico ocupa el 100% del ancho en pantallas pequeñas y 45% en pantallas más grandes */
.chart {
  flex: 1 1 calc(100% - 16px); /* 100% menos el espacio entre elementos */
  max-width: 400px;
}

@media (min-width: 768px) {
  .chart {
    flex: 1 1 calc(45% - 16px); /* 45% menos el espacio entre elementos */
  }
}
</style>


<script>
import Chart from "chart.js/auto";

export default {
  data() {
    return {
      generoChart: null,
      tipoSangreChart: null,
      currentData: {
        masculino: 0,
        femenino: 0,
        otro: 0,
        ap: 0,
        an: 0,
        bp: 0,
        bn: 0,
        abp: 0,
        abn: 0,
        op: 0,
        on: 0,
      },
    };
  },
  mounted() {
    this.CargarAPI();
    setInterval(this.CargarAPI, 10000); // Actualiza cada 10 segundos
  },
  methods: {
    CargarAPI() {
      const token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOb21icmVfVXN1YXJpbyI6IkFydHVybyIsIkNvcnJlb19FbGVjdHJvbmljbyI6InN0cmluZyIsIkNvbnRyYXNlbmEiOiIxMjMiLCJOdW1lcm9fVGVsZWZvbmljb19Nb3ZpbCI6InN0cmluZyJ9.SsK8F6Kdj41MK2iip-McFVoVrm2__IQOOcRu4DNjRdE";

      fetch("https://backenhospital.onrender.com/persons/", {
        method: "GET",
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        },
      })
        .then((response) => {
          if (!response.ok) {
            throw new Error("Error al recuperar los datos");
          }
          return response.json();
        })
        .then((data) => {
          console.log(data);

          // Inicializa contadores
          const counts = {
            masculino: 0,
            femenino: 0,
            otro: 0,
            ap: 0,
            an: 0,
            bp: 0,
            bn: 0,
            abp: 0,
            abn: 0,
            op: 0,
            on: 0,
          };

          // Recorre los datos y cuenta
          data.forEach((person) => {
            if (person.Genero === "Masculino") counts.masculino++;
            else if (person.Genero === "Femenino") counts.femenino++;
            else counts.otro++;

            // Cuenta tipos de sangre
            const tipoSangre = person.Tipo_Sangre;
            if (tipoSangre === "A+") counts.ap++;
            else if (tipoSangre === "A-") counts.an++;
            else if (tipoSangre === "B+") counts.bp++;
            else if (tipoSangre === "B-") counts.bn++;
            else if (tipoSangre === "AB+") counts.abp++;
            else if (tipoSangre === "AB-") counts.abn++;
            else if (tipoSangre === "O+") counts.op++;
            else if (tipoSangre === "O-") counts.on++;
          });

          if (JSON.stringify(this.currentData) !== JSON.stringify(counts)) {
            this.currentData = counts;
            this.ActualizarDatos(counts);
          }
        })
        .catch((error) => {
          console.error("Error al cargar los datos desde la API:", error);
        });
    },

    ActualizarDatos(data) {
      const { masculino, femenino, otro, ap, an, bp, bn, abp, abn, op, on } = data;

      if (this.generoChart) {
        this.generoChart.destroy();
      }
      if (this.tipoSangreChart) {
        this.tipoSangreChart.destroy();
      }

      const ctxGenero = document.getElementById("generoChart").getContext("2d");
      this.generoChart = new Chart(ctxGenero, {
        type: "pie",
        data: {
          labels: ["Masculino", "Femenino", "Otro"],
          datasets: [
            {
              label: "Género",
              data: [masculino, femenino, otro],
              backgroundColor: ["skyblue", "lightpink", "lightgray"],
            },
          ],
        },
        options: {
          responsive: true,
          plugins: {
            title: {
              display: true,
              text: "Distribución por Género",
            },
            tooltip: {
              enabled: true,
            },
          },
        },
      });

      const ctxTipoSangre = document
        .getElementById("tipoSangreChart")
        .getContext("2d");
      this.tipoSangreChart = new Chart(ctxTipoSangre, {
        type: "pie",
        data: {
          labels: ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"],
          datasets: [
            {
              label: "Tipo de Sangre",
              data: [ap, an, bp, bn, abp, abn, op, on],
              backgroundColor: [
                "red",
                "blue",
                "green",
                "orange",
                "purple",
                "yellow",
                "cyan",
                "magenta",
              ],
            },
          ],
        },
        options: {
          responsive: true,
          plugins: {
            title: {
              display: true,
              text: "Distribución por Tipo de Sangre",
            },
            tooltip: {
              enabled: true,
            },
          },
        },
      });
    },
  },
};
</script>

<style scoped>
.row {
  display: flex;
  flex-wrap: wrap;
}

.column {
  flex-basis: 50%;
  padding: 10px;
  box-sizing: border-box;
}

@media screen and (max-width: 600px) {
  .column {
    flex-basis: 100%;
  }
}
</style>