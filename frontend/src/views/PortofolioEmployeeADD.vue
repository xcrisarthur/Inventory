<template>
    <div>
        <h1>Portfolio Employee Add Data</h1>

        <div class="container">
            <form @submit.prevent="createSkills">
                <div class="row row-cols-2 row-cols-lg-3 g-lg-3">
                    <div class="col">
                        <div class="">
                            <label for="id_portfolio_karyawan" class="form-label">ID PORTFOLIO KARYAWAN</label>
                            <input v-model="newSkill.id_portfolio_karyawan" type="text" class="form-control"
                                id="id_portfolio_karyawan">
                        </div>
                    </div>

                    <div class="col">
                        <div class="">
                            <label for="id_portfolio" class="form-label">ID PORTFOLIO</label>
                            <select v-model="newSkill.id_portfolio" class="form-select" id="id_portfolio">
                                <option v-for="portfolio in portfolios" :value="portfolio.id_portfolio"
                                    :key="portfolio.id_portfolio">
                                    {{ portfolio.nama }}
                                </option>
                            </select>
                        </div>
                    </div>

                    <div class="col">
                        <div class="">
                            <label for="nomor_induk" class="form-label">NOMOR INDUK</label>
                            <select v-model="newSkill.nomor_induk" class="form-select" id="nomor_induk">
                                <option v-for="employee in employees" :value="employee.nomor_induk"
                                    :key="employee.nomor_induk">
                                    {{ employee.nama }}
                                </option>
                            </select>
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
            newSkill: {
                id_portfolio_karyawan: '',
                id_portfolio: '',
                nomor_induk: '',
            },
            portfolios: [],
            employees: [],

        };
    },
    mounted() {
        this.fetchPortfolios();
        this.fetchEmployees();

    },
    methods: {
        createSkills() {
            axios.post('http://localhost:8080/api/employeePortfolio', this.newSkill)
                // eslint-disable-next-line no-unused-vars
                .then(response => {
                    this.newSkill = {};
                    router.push({ path: `/SkillsEmployee` });
                })
                .catch(error => {
                    console.error('Error creating inventory:', error);
                });
        },
        fetchPortfolios() {
            axios.get('http://localhost:8080/api/portfolio')
                .then(response => {
                    this.portfolios = response.data.portfolios;
                    console.log(response.data.portfolios)
                })
                .catch(error => {
                    console.error('Error fetching location:', error);
                });
        },
        fetchEmployees() {
            axios.get('http://localhost:8080/api/employees')
                .then(response => {
                    this.employees = response.data.employees;
                    console.log(response.data.employees)
                })
                .catch(error => {
                    console.error('Error fetching location:', error);
                });
        },
    },
};
</script>

<style></style>