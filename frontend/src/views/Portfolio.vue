<template>
  <div>
    <h1>Employee List</h1>
    <div class="d-flex flex-row mb-3">
      <div class="p-2 me-5">
        <button type="button" class="btn btn-success text-dark" @click="redirectToAddPage">Add Data</button>
      </div>
    </div>
    <div class="table-responsive">
      <table class="table table-bordered">
        <!-- Header Tabel -->
        <thead class="table-dark">
          <tr>
            <th>Nomor Induk</th>
            <th>Image URL</th>
            <th>Nama</th>
            <th>Gender</th>
            <th>Email</th>
            <th>Telepon</th>
            <th>Jabatan</th>
            <th>Divisi</th>
            <th>Alamat</th>
          </tr>
        </thead>

        <!-- Tabel Karyawan -->
        <tbody>
          <tr v-for="employee in employeeData" :key="employee.nomor_induk">
            <td>{{ employee.nomor_induk }}</td>
            <td>{{ employee.gambar }}</td>
            <td>{{ employee.nama }}</td>
            <td>{{ employee.gender ? 'Laki-laki' : 'Perempuan' }}</td>
            <td>{{ employee.email }}</td>
            <td>{{ employee.telepon }}</td>
            <td>{{ employee.jabatan }}</td>
            <td>{{ employee.divisi }}</td>
            <td>{{ employee.alamat }}</td>
          </tr>
        </tbody>
      </table>
    </div>

    <h1>Skill List</h1>
    <div class="table-responsive">
      <table class="table table-bordered">
        <!-- Header Tabel -->
        <thead class="table-dark">
          <tr>
            <th>ID Skill</th>
            <th>Nama</th>
            <th>Level</th>
            <th>Notes</th>
          </tr>
        </thead>

        <!-- Tabel Keahlian -->
        <tbody>
          <tr v-for="skill in skillData" :key="skill.id_skill">
            <td>{{ skill.id_skill }}</td>
            <td>{{ skill.nama }}</td>
            <td>{{ skill.level }}</td>
            <td>{{ skill.notes }}</td>
          </tr>
        </tbody>
      </table>
    </div>

    <h1>Portfolio List</h1>
    <div class="table-responsive">
      <table class="table table-bordered">
        <!-- Header Tabel -->
        <thead class="table-dark">
          <tr>
            <th>ID Portfolio</th>
            <th>Nama</th>
            <th>Tanggal</th>
            <th>Deskripsi</th>
            <th>Role</th>
            <th>Technology</th>
          </tr>
        </thead>

        <!-- Tabel Portfolio -->
        <tbody>
          <tr v-for="portfolio in portfolioData" :key="portfolio.id_portfolio">
            <td>{{ portfolio.id_portfolio }}</td>
            <td>{{ portfolio.nama }}</td>
            <td>{{ portfolio.tanggal }}</td>
            <td>{{ portfolio.deskripsi }}</td>
            <td>{{ portfolio.role }}</td>
            <td>{{ portfolio.technology }}</td>
          </tr>
        </tbody>
      </table>
    </div>

    <h1>Skill Employee List</h1>
    <div class="table-responsive">
      <table class="table table-bordered">
        <!-- Header Tabel -->
        <thead class="table-dark">
          <tr>
            <th>Id Skill Karyawan</th>
            <th>Id Skill</th>
            <th>Nomor Induk</th>
          </tr>
        </thead>

        <tbody>
          <tr v-for="skillEmployee in EmployeeskillData" :key="skillEmployee.id_skill_karyawan">
            <td>{{ skillEmployee.id_skill_karyawan }}</td>
            <td>{{ skillEmployee.id_skill }}</td>
            <td>{{ skillEmployee.nomor_induk }}</td>
          </tr>
        </tbody>
      </table>
    </div>

    <h1>Portfolio Employee List</h1>
    <div class="table-responsive">
      <table class="table table-bordered">
        <!-- Header Tabel -->
        <thead class="table-dark">
          <tr>
            <th>Id Portfolio Karyawan</th>
            <th>Id Portfolio</th>
            <th>Nomor Induk</th>
          </tr>
        </thead>

        <!-- Tabel Portfolio -->
        <tbody>
          <tr v-for="Employeeportfolio in EmployeeportfolioData" :key="Employeeportfolio.id_portfolio_karyawan">
            <td>{{ Employeeportfolio.id_portfolio_karyawan }}</td>
            <td>{{ Employeeportfolio.id_portfolio }}</td>
            <td>{{ Employeeportfolio.nomor_induk }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      loading: true,
      error: null,
      employeeData: [],
      skillData: [],
      portfolioData: [],
      EmployeeskillData: [],
      EmployeeportfolioData: [],
    };
  },
  mounted() {
    // Fetching data for employees
    axios
      .get('http://localhost:8080/api/employees')
      .then((response) => {
        console.log('Employee Data:', response.data.employees);
        this.employeeData = response.data.employees;
      })
      .catch((error) => {
        console.error('Error fetching employee data:', error);
        this.error = 'Failed to fetch employee data';
      })
      .finally(() => {
        this.loading = false;
      });

    axios
      .get('http://localhost:8080/api/skills')
      .then((response) => {
        console.log('Skill Data:', response.data.skills);
        this.skillData = response.data.skills;
      })
      .catch((error) => {
        console.error('Error fetching skill data:', error);
        this.error = 'Failed to fetch skill data';
      });

    axios
      .get('http://localhost:8080/api/portfolio')
      .then((response) => {
        console.log('Portfolio Data:', response.data.portfolios);
        this.portfolioData = response.data.portfolios;
      })
      .catch((error) => {
        console.error('Error fetching portfolio data:', error);
        this.error = 'Failed to fetch portfolio data';
      });

    axios
      .get('http://localhost:8080/api/employeeSkills')
      .then((response) => {
        console.log('Employee Skill Data:', response.data.skillEmployees);
        this.EmployeeskillData = response.data.skillEmployees;
      })
      .catch((error) => {
        console.error('Error fetching skill data:', error);
        this.error = 'Failed to fetch skill data';
      });

    axios
      .get('http://localhost:8080/api/employeePortfolio')
      .then((response) => {
        console.log('Employee Portfolio Data:', response.data.portfolioEmployees);
        this.EmployeeportfolioData = response.data.portfolioEmployees;
      })
      .catch((error) => {
        console.error('Error fetching portfolio data:', error);
        this.error = 'Failed to fetch portfolio data';
      });
  },
  methods: {
    redirectToAddPage() {
      // Implement the logic to redirect to the add page
    },
  },
};
</script>
