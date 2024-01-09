<template>
    <h1>Page Damage History</h1>
  
    <div class="d-flex flex-row mb-3">
      <div class="p-2">
        <div class="col">
        </div>
        <!-- <div class="col pt-3">
          <div class="input-group flex-nowrap">
            <span class="input-group-text" id="addon-wrapping"><i class="fas fa-search" aria-hidden="true"></i></span>
            <input v-model="searchText" @input="filterItems" type="text" class="form-control"
              placeholder="Search History..." aria-label="Username" aria-describedby="addon-wrapping" />
          </div>
        </div> -->
      </div>
    </div>
  
    <!-- <div class="container text-center">
      <div class="row align-items-start">
        <div class="col">
          <p class="fw-bold fs-4">F I L T E R</p>
        </div>
        <div class="col">
          <select v-model="selectedIndukOld" class="form-select" aria-label="Default select example">
            <option value="InOld">Induk Old</option>
            <option v-for="inOld in uniqueIndukOlds" :key="inOld" :value="inOld">{{ inOld }}</option>
          </select>
        </div>
        <div class="col">
          <select v-model="selectedIndukNew" class="form-select" aria-label="Default select example">
            <option value="InNew">Induk New</option>
            <option v-for="inNew in uniqueIndukNews" :key="inNew" :value="inNew">{{ inNew }}</option>
          </select>
        </div>
        <div class="col">
          <select v-model="selectedTanggal" class="form-select" aria-label="Default select example">
            <option value="Tanggal">Tanggal</option>
            <option v-for="tanggal in uniqueTanggals" :key="tanggal" :value="tanggal">{{ tanggal }}</option>
          </select>
        </div>
      </div>
    </div> -->
  
    <table class="table table-striped text-center ">
      <thead>
        <tr>
          <th class="text-uppercase"> Tangal <br> Kerusakan </th>
          <th class="text-uppercase"> Nama <br> Ruangan </th>
          <th class="text-uppercase"> Nama <br> Karyawan </th>
          <th class="text-uppercase"> Nama <br> Aset </th>
          <th class="text-uppercase"> Kategori </th>
          <th class="text-uppercase"> Status </th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="damage in DamageList" :key="damage.id">
          <td>{{ damage.tanggal_kerusakan }}</td>
          <td>{{ damage.usage.Room.nama }} <br> ( {{ damage.usage.Room.Location.nama }} )</td>
          <td>{{ damage.usage.Employee.nama }}</td>
          <td>{{ damage.usage.Inventory.nama }}</td>
          <td>{{ damage.usage.Inventory.Category.nama }}</td>
          <td>{{ damage.usage.status }}</td>
        </tr>
      </tbody>
    </table>
  </template>
    
  <script>
  export default {
    data() {
      return {
        damageCsv: [],
        selectedDamage: {},
        fileSelected: false,
        modalBackgroundColor: 'rgba(0, 0, 0, 0.50)',
        searchText: '',
        selectedIndukOld: 'Pemakai Sebelumnya',
        selectedIndukNew: 'Pemakai Sekarang',
        selectedTanggal: 'Tanggal',
        selectedRuanganOld: 'Ruangan Sebelumnya',
        selectedRuanganNew: 'Ruangan Sekarang',
      };
    },
    computed: {
      DamageList() {
        return this.$store.state.DamageList;
      },
      employees() {
        // console.log(this.$store.state.employees)
        return this.$store.state.employees;
      },
      rooms() {
        return this.$store.state.rooms;
      },
      filteredUsageHistories() {
        return this.usageHistories.filter(ReportHistories =>
          this.searchInventories(ReportHistories, this.searchText.toLowerCase()) &&
          (this.selectedIndukOld === 'Pemakai Sebelumnya' || ReportHistories.nomor_induk_old === this.selectedIndukOld) &&
          (this.selectedNomor === 'Pemakai Sekarang' || ReportHistories.nomor_induk_new === this.selectedNomor) &&
          (this.selectedTanggal === 'Tanggal' || ReportHistories.tanggal === this.selectedTanggal) &&
          (this.selectedRuanganOld === 'Ruangan Sebelumnya' || ReportHistories.ruangan_old === this.selectedRuanganOld)
          (this.selectedRuanganNew === 'Ruangan Sekarang' || ReportHistories.ruangan_new === this.selectedRuanganNew)
  
        );
      },
      filteredInventoriesCsv() {
        return this.damageCsv.filter(ReportHistories =>
          this.searchInventories(ReportHistories, this.searchText.toLowerCase())
        );
      },
      uniqueIndukOlds() {
        const indukOld = this.usageHistories.map(ReportHistories => ReportHistories.nomor_induk_old).filter(Boolean);
        return [...new Set(indukOld)];
      },
      uniqueIndukNews() {
        const indukNew = this.usageHistories.map(ReportHistories => ReportHistories.nomor_induk_new).filter(Boolean);
        return [...new Set(indukNew)];
      },
      uniqueTanggals() {
        const tanggal = this.usageHistories.map(ReportHistories => ReportHistories.tanggal).filter(Boolean);
        return [...new Set(tanggal)];
      },
      uniqueRoomOld() {
        const roomOld = this.usageHistories.map(ReportHistories => ReportHistories.ruangan_old).filter(Boolean);
        return [...new Set(roomOld)];
      },
      uniqueRoomNew() {
        const roomNew = this.usageHistories.map(ReportHistories => ReportHistories.ruangan_new).filter(Boolean);
        return [...new Set(roomNew)];
      },
    },
    mounted() {
      this.$store.dispatch('fetchData', {
        endpoint: 'logProblem',
        dataKey: 'Kerusakan',
        mutation: 'setDamageList',
      });
      this.$store.dispatch('fetchData', {
        endpoint: 'employees',
        dataKey: 'employees',
        mutation: 'setEmployeesList',
      });
      this.$store.dispatch('fetchData', {
        endpoint: 'rooms',
        dataKey: 'rooms',
        mutation: 'setRoomsList',
      });
    },
    methods: {
      searchHistory(id, searchText) {
        return Object.values(id).some(
          value => value && value.toString().toLowerCase().includes(searchText)
        );
      },
      showDetailModal(id) {
        this.selectedInventories = id;
        this.modalBackgroundColor = 'rgba(0, 0, 0, 0.6)';
        const modalElement = document.getElementById('staticBackdrop');
        if (modalElement) {
          modalElement.modal('show');
        } else {
          console.error('Modal element not found.');
        }
      },
      getEmployeeName(nomorInduk) {
        const employee = this.employees.find(emp => emp.nomor_induk === nomorInduk);
        return employee ? employee.nama : 'Employee Not Found';
      },
      getRoomName(ruangan_old) {
        const room = this.rooms.find(emp => emp.id_ruangan === ruangan_old);
        return room ? room.nama : 'room Not Found';
      },
    }
  };
  </script>
    
  <style></style>