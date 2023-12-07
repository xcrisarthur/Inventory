<template>
  <div class="py-4 container-fluid">
    <div class="row">
      <div class="col-sm-4 mb-3 mb-sm-0 mb-4">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Special title treatment</h5>
            <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
            <!-- <a href="#" class="btn btn-primary">Go somewhere</a> -->
          </div>
        </div>
      </div>
      <div class="col-sm-4 mb-4">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Special title treatment</h5>
            <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
            <!-- <a href="#" class="btn btn-primary">Go somewhere</a> -->
          </div>
        </div>
      </div>
      <div class="col-sm-4 mb-4">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Special title treatment</h5>
            <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
            <!-- <a href="#" class="btn btn-primary">Go somewhere</a> -->
          </div>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="col-lg-7 mb-lg-0 mb-4">
        <div class="card">
          <div class="card-body p-3">
            <div class="row">
              <div class="col-lg-12">
                <div class="d-flex flex-column h-100">
                  <p class="mb-1 pt-2 text-bold">Grafik Lines</p>
                  <h5 class="font-weight-bolder">Grafik Lines.</h5>
                  <p class="mb-5">
                    Lorem ipsum dolor sit amet consectetur adipisicing elit. Fugiat quasi adipisci repellendus voluptates
                    velit veniam.
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-5">
        <div class="card h-100 p-3">
          <div class="overflow-hidden position-relative border-radius-lg bg-cover h-100">
            <!-- <span class="mask"></span> -->
            <div class="card-body position-relative z-index-1 p-3 h-100">
              <div class="d-flex flex-column h-100">
                <h5 class="font-weight-bolder mb-4 pt-2">
                  Pie Chart
                </h5>
                <p class="mb-5">
                  Lorem ipsum dolor sit amet consectetur adipisicing elit. Sed non placeat asperiores harum.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="mt-4 row">
      <div class="mb-4 col-lg-5 mb-lg-0">
        <div class="card z-index-2">
          <div class="p-3 card-body">
            <reports-bar-chart id="chart-bar" title="lorem ipsum dolor sit amot" description="" :chart="{
              labels: [
                'Apr',
                'May',
                'Jun',
                'Jul',
                'Aug',
                'Sep',
                'Oct',
                'Nov',
                'Dec',
              ],
              datasets: {
                label: 'Sales',
                data: [450, 200, 100, 220, 500, 100, 400, 230, 500],
              },
            }" :items="[
  {
    icon: {
      color: 'primary',
      component: faUsers,
    },
    label: 'lorem',
    progress: { content: '??', percentage: 10 },
  },
  {
    icon: { color: 'info', component: faHandPointer },
    label: 'ipsum',
    progress: { content: '??', percentage: 30 },
  },
  {
    icon: { color: 'warning', component: faCreditCard },
    label: 'dolor',
    progress: { content: '??', percentage: 60 },
  },
  {
    icon: { color: 'danger', component: faScrewdriverWrench },
    label: 'sit',
    progress: { content: '??', percentage: 90 },
  },
]" />
          </div>
        </div>
      </div>
      <div class="col-lg-7">
        <!-- line chart -->
        <div class="card z-index-2">
          <gradient-line-chart id="chart-line" title="Gradient Line Chart" description="" :chart="{
            labels: [
              'Apr',
              'May',
              'Jun',
              'Jul',
              'Aug',
              'Sep',
              'Oct',
              'Nov',
              'Dec',
            ],
            datasets: [
              {
                label: 'Mobile Apps',
                data: [50, 40, 300, 220, 500, 250, 400, 230, 500],
              },
              {
                label: 'Websites',
                data: [30, 90, 40, 140, 290, 290, 340, 230, 400],
              },
            ],
          }" />
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import ReportsBarChart from "@/examples/Charts/ReportsBarChart.vue";
import GradientLineChart from "@/examples/Charts/GradientLineChart.vue";
import US from "../assets/img/icons/flags/US.png";
import DE from "../assets/img/icons/flags/DE.png";
import GB from "../assets/img/icons/flags/GB.png";
import BR from "../assets/img/icons/flags/BR.png";
import {
  faHandPointer,
  faUsers,
  faCreditCard,
  faScrewdriverWrench,
} from "@fortawesome/free-solid-svg-icons";
export default {
  name: "dashboard-default",
  data() {
    return {
      iconBackground: "bg-gradient-dark",
      faCreditCard,
      faScrewdriverWrench,
      faUsers,
      faHandPointer,
      sales: {
        us: {
          country: "United States",
          sales: 2500,
          value: "$230,900",
          bounce: "29.9%",
          flag: US,
        },
        germany: {
          country: "Germany",
          sales: "3.900",
          value: "$440,000",
          bounce: "40.22%",
          flag: DE,
        },
        britain: {
          country: "Great Britain",
          sales: "1.400",
          value: "$190,700",
          bounce: "23.44%",
          flag: GB,
        },
        brasil: {
          country: "Brasil",
          sales: "562",
          value: "$143,960",
          bounce: "32.14%",
          flag: BR,
        },
      },
    };
  },
  components: {
    ReportsBarChart,
    GradientLineChart,
  },
};
</script>
