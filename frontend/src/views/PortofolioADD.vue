<template>
    <div>
      <h1>Portfolio Add Data</h1>
  
      <div class="container">
        <form @submit.prevent="createPortfolios">
          <div class="row row-cols-2 row-cols-lg-3 g-lg-3">
            <div class="col">
              <div class="">
                <label for="id_portfolio" class="form-label">ID PORTFOLIO</label>
                <input v-model="newPortfolios.id_portfolio" type="text" class="form-control" id="id_portfolio" required>
              </div>
            </div>
  
            <div class="col">
              <div class="">
                <label for="nama" class="form-label">NAMA</label>
                <input v-model="newPortfolios.nama" type="text" class="form-control" id="nama" required>
              </div>
            </div>
  
            <div class="col">
              <div class="">
                <label for="tanggal" class="form-label">TANGGAL</label>
                <input v-model="newPortfolios.tanggal" type="date" class="form-control" id="tanggal" required>
              </div>
            </div>
  
            <div class="col">
              <div class="">
                <label for="deskripsi" class="form-label">DESKRIPSI</label>
                <input v-model="newPortfolios.deskripsi" type="text" class="form-control" id="deskripsi" required>
              </div>
            </div>
  
            <div class="col">
              <div class="">
                <label for="role" class="form-label">ROLE</label>
                <input v-model="newPortfolios.role" type="text" class="form-control" id="role" required>
              </div>
            </div>
  
            <div class="col">
              <div class="">
                <label for="technology" class="form-label">TECHNOLOGY</label>
                <input v-model="newPortfolios.technology" type="text" class="form-control" id="technology" required>
              </div>
            </div>
  
            <div class="col">
              <button type="submit" class="btn btn-primary">Add Data</button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </template>
  
  <script>
  import axios from 'axios';
  import router from '../router';
  
  export default {
    data() {
      return {
        newPortfolios: {
          id_portfolio: 'asd12',
          nama: 'zxcasd',
          tanggal: '17/11/2023',
          deskripsi: 'test',
          role: 'testt',
          technology: 'testtt',
        },
        portfolios: [],
      };
    },
    mounted() {
      this.fetchPortfolios();
    },
    methods: {
      createPortfolios() {
        axios.post('http://localhost:8080/api/portfolio', this.newPortfolios)
          .then(response => {
            // Reset form fields individually for better UX
            this.newPortfolios.id_portfolio = '';
            this.newPortfolios.nama = '';
            this.newPortfolios.tanggal = '';
            this.newPortfolios.deskripsi = '';
            this.newPortfolios.role = '';
            this.newPortfolios.technology = '';
            console.log(response)
            router.push({ path: `/Portofolio` });
          })
          .catch(error => {
            console.error('Error creating portfolio:', error);
          });
      },
      fetchPortfolios() {
        axios.get('http://localhost:8080/api/portfolio')
          .then(response => {
            this.portfolios = response.data.portfolios;
          })
          .catch(error => {
            console.error('Error fetching portfolios:', error);
          });
      },
    },
  };
  </script>
  
  <style></style>
  