<template>
    <div>
      <h1>Portfolio Edit</h1>
      <div class="container">
        <form @submit.prevent="updatePortfolio">
            <div class="row row-cols-2 row-cols-lg-3 g-lg-3">

          <div class="form-group col">
            <label for="id_portfolio">ID PORTFOLIO</label>
            <input v-model="portfolio.id_portfolio" type="text" class="form-control" id="id_portfolio" disabled>
          </div>
  
          <div class="form-group col">
            <label for="nama">NAMA</label>
            <input v-model="portfolio.nama" type="text" class="form-control" id="nama" required>
          </div>
  
          <div class="form-group col">
            <label for="tanggal">TANGGAL</label>
            <input v-model="portfolio.tanggal" type="date" class="form-control" id="tanggal" required>
          </div>
  
          <div class="form-group col">
            <label for="deskripsi">DESKRIPSI</label>
            <input v-model="portfolio.deskripsi" type="text" class="form-control" id="deskripsi" required>
          </div>
  
          <div class="form-group col">
            <label for="role">ROLE</label>
            <input v-model="portfolio.role" type="text" class="form-control" id="role" required>
          </div>
  
          <div class="form-group col">
            <label for="technology">TECHNOLOGY</label>
            <input v-model="portfolio.technology" type="text" class="form-control" id="technology" required>
          </div>
        </div>
  
          <button type="submit" class="btn btn-primary">Update Data</button>

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
        portfolio: {
          id_portfolio: '',
          nama: '',
          tanggal: '',
          deskripsi: '',
          role: '',
          technology: '',
        },
      };
    },
    created() {
      this.fetchPortfolioItem();
    },
    methods: {
      fetchPortfolioItem() {
        const itemId = this.$route.params.id;
        axios.get(`http://localhost:8080/api/portfolio/${itemId}`)
          .then(response => {
            this.portfolio = response.data.portfolio;
          })
          .catch(error => {
            console.error('Error fetching portfolio item:', error);
          });
      },
      updatePortfolio() {
        axios.put(`http://localhost:8080/api/portfolio/${this.portfolio.id_portfolio}`, this.portfolio)
          .then(() => {
            alert('Portfolio item updated successfully');
            router.push({ path: `/Portofolio` });
          })
          .catch(error => {
            console.error('Error updating portfolio item:', error);
          });
      },
    },
  };
  </script>
  
  <style>
  /* Add your custom styles here */
  </style>
  