<template>
  <div>
    <div class="row">
      <div class="column">
        <canvas id="generoChart" width="400" height="400"></canvas>
      </div>
      <div class="column">
        <canvas id="tipoSangreChart" width="400" height="400"></canvas>
      </div>
    </div>
  </div>
</template>

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
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOb21icmVfVXN1YXJpbyI6Impvc2UiLCJDb3JyZW9fRWxlY3Ryb25pY28iOiJzdHJpbmciLCJDb250cmFzZW5hIjoiMTIzIiwiTnVtZXJvX1RlbGVmb25pY29fTW92aWwiOiJzdHJpbmcifQ.F5Gx0BbrFleRj2mjwGlg2EKolfDfWA_h93se45tcaoM";

      fetch("http://127.0.0.1:8000/persons/", {
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