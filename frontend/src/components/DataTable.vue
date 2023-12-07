<template>
    <div>
      <h1>Datatables Demo</h1>
  
      <table class="table">
        <thead>
          <tr>
            <th>Nama</th>
            <th>Umur</th>
            <th>Alamat</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="user in users" :key="user.id">
            <td>{{ user.nama }}</td>
            <td>{{ user.umur }}</td>
            <td>{{ user.alamat }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </template>
  
  <script>
  import DataTable from 'datatables.net-vue3';
  
  export default {
    data() {
      return {
        users: [],
      };
    },
    mounted() {
      // Load data from API
      this.$axios.get('/api/users').then((response) => {
        this.users = response.data;
      });
    },
    components: {
      // eslint-disable-next-line vue/no-unused-components
      DataTable,
    },
  };
  </script>
  