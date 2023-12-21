<template>
  <div class="py-4 container-fluid">
    <!-- <div class="row text-center">
      <div class="col-sm-4 mb-4">
        <div class="card">
          <div class="card-body border border-1 border-dark rounded-3">
            <h4 class="card-title">Quantity Of Inventory</h4>
            <p class="card-text">{{ inventories.length }}</p>
          </div>
        </div>
      </div>
      <div class="col-sm-4 mb-3 mb-sm-0 mb-4">
        <div class="card">
          <div class="card-body border border-1 border-dark rounded-3">
            <h4 class="card-title">Quantity Of Room</h4>
            <p class="card-text">{{ rooms.length }}</p>
          </div>
        </div>
      </div>
      <div class="col-sm-4 mb-4">
        <div class="card">
          <div class="card-body border border-1 border-dark rounded-3">
            <h4 class="card-title">Quantity Of Employee</h4>
            <p class="card-text">{{ employees.length }}</p>
          </div>
        </div>
      </div>
    </div> -->

    <div class="row">
      <div class="col-lg-7 mb-lg-0">
        <div class="card">
          <div class="card-body p-3">
            <select v-model="selectedInventory" class="form-select" id="kode_aset">
              <option v-for="inventory in inventories" :value="inventory.kode_aset" :key="inventory.kode_aset">
                {{ inventory.nama }}
              </option>
            </select>
            <canvas id="lineChart"></canvas>

          </div>
        </div>
      </div>
      <div class="col-lg-5">
        <div class="card">
          <div class="card-body">
            <canvas id="pieChart"></canvas>
          </div>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="col-lg-7 mb-lg-0 mb-4">
        <div class="card">
          <div class="card-body p-3">
            <canvas id="barChart"></canvas>

          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import Chart from 'chart.js/auto';

export default {
  name: "dashboard-default",
  data() {
    return {
      inventories: [],
      rooms: [],
      employees: [],
      selectedInventory: null,
    };
  },
  watch: {
    selectedInventory: 'renderLineChart',
  },
  mounted() {
    this.fetchInventoriesSelected();

    this.fetchInventories();
    this.fetchRooms();
    this.fetchEmployees();
    this.renderCharts();
    this.fetchAllData();

  },

  methods: {
    fetchInventories() {
      axios.get('http://localhost:8080/api/inventories')
        .then(response => {
          this.inventories = response.data.inventory;
        })
        .catch(error => {
          console.error('Error fetching inventories:', error);
          alert('Failed to fetch inventories. Please try again later.');
        });
    },
    fetchInventoriesSelected() {
      axios.get('http://localhost:8080/api/inventories')
        .then(response => {
          this.inventories = response.data.inventory;
          this.selectedInventory = this.inventories.length > 0 ? this.inventories[0].kode_aset : null;
        })
        .catch(error => {
          console.error('Error fetching inventories:', error);
          alert('Failed to fetch inventories. Please try again later.');
        });
    },
    fetchRooms() {
      axios.get('http://localhost:8080/api/rooms')
        .then(response => {
          this.rooms = response.data.rooms;
        })
        .catch(error => {
          console.error('Error fetching rooms:', error);
        });
    },
    fetchEmployees() {
      axios.get('http://localhost:8080/api/employees')
        .then(response => {
          this.employees = response.data.employees;
        })
        .catch(error => {
          console.error('Error fetching employees:', error);
        });
    },
    fetchAllData() {
      axios.all([
        axios.get('http://localhost:8080/api/inventories'),
        axios.get('http://localhost:8080/api/rooms'),
        axios.get('http://localhost:8080/api/employees')
      ])
        .then(axios.spread((inventoriesResponse, roomsResponse, employeesResponse) => {
          this.inventories = inventoriesResponse.data.inventory;
          this.rooms = roomsResponse.data.rooms;
          this.employees = employeesResponse.data.employees;

          // console.log(this.inventories, this.rooms, this.employees)
        }))
        .catch(error => {
          console.error('Error fetching data:', error);
          alert('Failed to fetch data. Please try again later.');
        });
    },
    renderCharts() {
      this.renderBarChart();
      this.renderPieChart();
      this.renderLineChart();
    },
    renderBarChart() {
      axios.all([
        axios.get('http://localhost:8080/api/inventories'),
        axios.get('http://localhost:8080/api/rooms'),
        axios.get('http://localhost:8080/api/employees'),
        axios.get('http://localhost:8080/api/categories'),
        axios.get('http://localhost:8080/api/locations')

      ])
        .then(axios.spread((inventoriesResponse, roomsResponse, employeesResponse, categoriesResponse, locationsResponse) => {
          this.inventories = inventoriesResponse.data.inventory;
          this.rooms = roomsResponse.data.rooms;
          this.employees = employeesResponse.data.employees;
          this.categories = categoriesResponse.data.categories;
          this.locations = locationsResponse.data.locations;

          const barChart = document.getElementById('barChart');
          new Chart(barChart, {
            type: 'bar',
            data: {
              labels: ['Inventory', 'Room', 'Category', 'Employee', 'Location'],
              datasets: [{
                label: 'All Quatity of Data',
                data: [this.inventories.length, this.rooms.length, this.categories.length, this.employees.length, this.locations.length],
                borderWidth: 1,
                backgroundColor: [
                  'rgba(95,111,82, 1)',
                  'rgba(169,179,136, 1)',
                  'rgba(185,148,112, 1)',
                  'rgba(92,131,116, 1)',
                  'rgba(185,180,199, 1)',

                ],
                borderColor: [
                  'rgba(95,111,82, 1)',
                  'rgba(169,179,136, 1)',
                  'rgba(185,148,112, 1)',
                  'rgba(92,131,116, 1)',
                  'rgba(185,180,199, 1)',
                ]
              }]
            },
            options: {
              scales: {
                y: {
                  beginAtZero: true
                }
              }
            }
          });

        }))
        .catch(error => {
          console.error('Error fetching data:', error);
          alert('Failed to fetch data. Please try again later.');
        });

    },
    calculateStatusQuantity() {
      const baikCount = this.usages.filter(usage => usage.status === 'baik').length;
      const rusakCount = this.usages.filter(usage => usage.status === 'rusak').length;

      return [baikCount, rusakCount];
    },
    renderPieChart() {
      axios.all([
        axios.get('http://localhost:8080/api/inventories'),
        axios.get('http://localhost:8080/api/rooms'),
        axios.get('http://localhost:8080/api/employees'),
        axios.get('http://localhost:8080/api/categories'),
        axios.get('http://localhost:8080/api/locations'),
        axios.get('http://localhost:8080/api/usages')

      ])
        .then(axios.spread((inventoriesResponse, roomsResponse, employeesResponse, categoriesResponse, locationsResponse, usagesResponse) => {
          this.inventories = inventoriesResponse.data.inventory;
          this.rooms = roomsResponse.data.rooms;
          this.employees = employeesResponse.data.employees;
          this.categories = categoriesResponse.data.categories;
          this.locations = locationsResponse.data.locations;
          this.usages = usagesResponse.data.usages;

          const [baikCount, rusakCount] = this.calculateStatusQuantity();

          const pieChart = document.getElementById('pieChart');
          new Chart(pieChart, {
            type: 'pie',
            data: {
              labels: ['Status Aset Baik', 'Status Aset Rusak'],
              datasets: [{
                label: 'Asets Condition',
                data: [baikCount, rusakCount],
                borderWidth: 1,
                backgroundColor: [
                  'rgba(0,150,0, 1)',
                  'rgba(150,0,0, 1)',

                ],
                borderColor: [
                  'rgba(0,150,0, 1)',
                  'rgba(150,0,0, 1)',
                ]
              }]
            },
            options: {
              scales: {
                y: {
                  beginAtZero: true
                }
              }
            }
          });

        }))
        .catch(error => {
          console.error('Error fetching data:', error);
          alert('Failed to fetch data. Please try again later.');
        });

    },
    renderLineChart() {
      if (!this.selectedInventory) return;

      // Hancurkan grafik yang ada jika sudah ada
      const existingChart = this.$data._chart;
      if (existingChart) {
        existingChart.destroy();
      }

      const selectedInventoryData = this.inventories.find(inventory => inventory.kode_aset === this.selectedInventory);
      const selectedTahun1 = selectedInventoryData.tahun_1;
      const selectedTahun2 = selectedInventoryData.tahun_2;
      const selectedTahun3 = selectedInventoryData.tahun_3;
      const selectedTahun4 = selectedInventoryData.tahun_4;

      // console.log('Selected Data:', selectedTahun1, selectedTahun2, selectedTahun3, selectedTahun4);

      const lineChart = document.getElementById('lineChart');
      const newChart = new Chart(lineChart, {
        type: 'line',
        data: {
          labels: ['Tahun 1', 'Tahun 2', 'Tahun 3', 'Tahun 4'],
          datasets: [{
            label: 'Depreciation Asset',
            data: [selectedTahun1, selectedTahun2, selectedTahun3, selectedTahun4],
            borderWidth: 1,
            tension: 0.5,
            backgroundColor: [
              'rgba(255, 99, 132, 1)',
              'rgba(90, 5, 132, 1)'
            ],
            borderColor: [
              'rgba(255, 99, 132, 1)',
              'rgba(90, 5, 132, 1)'
            ]
          }]
        },
        options: {
          scales: {
            y: {
              beginAtZero: true
            }
          }
        }
      });
      this.$data._chart = newChart;

    },
  }
};
</script>
