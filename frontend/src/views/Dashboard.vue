<template>
  <div class="py-4 container-fluid">
    <div class="row">
      <div class="col-sm-4 mb-4">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Jumlah Items</h5>
            <p class="card-text">{{ inventories.length }}</p>
            <!-- <a href="#" class="btn btn-primary">Go somewhere</a> -->
          </div>
        </div>
      </div>
      <div class="col-sm-4 mb-3 mb-sm-0 mb-4">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Jumlah Ruangan</h5>
            <p class="card-text">{{ rooms.length }}</p>
            <!-- <a href="#" class="btn btn-primary">Go somewhere</a> -->
          </div>
        </div>
      </div>
      <div class="col-sm-4 mb-4">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Jumlah Kayawan</h5>
            <p class="card-text">{{ employees.length }}</p>
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

  </div>
</template>
<script>
import axios from 'axios';

export default {
  name: "dashboard-default",
  data() {
    return {
      inventories: [],
      rooms: [],
      employees: [],
    };
  },
  mounted() {
    this.fetchInventories();
    this.fetchRooms();
    this.fetchEmployees();

  },
  methods: {
    fetchInventories() {
      axios.get('http://localhost:8080/api/inventories')
        .then(response => {
          this.inventories = response.data.inventory;
          console.log(this.inventories)
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
          console.log(this.rooms)
        })
        .catch(error => {
          console.error('Error fetching rooms:', error);
        });
    },
    fetchEmployees() {
      axios.get('http://localhost:8080/api/employees')
        .then(response => {
          this.employees = response.data.employees;
          console.log(this.employees)
        })
        .catch(error => {
          console.error('Error fetching employees:', error);
        });
    },
  }
};
</script>
