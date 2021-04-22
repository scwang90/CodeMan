import Vue from 'vue';

const filters = {
    gender(value) {
        if (value == 1 || value == '1') {
            return '男';
        } else if (value == 2 || value == '2') {
            return '女';
        }
        return '未设置';
    }
};

export default {
    install(Vue) {
        for (const filter in filters) {
            if (Object.hasOwnProperty.call(filters, filter)) {
                Vue.filter(filter, filters[filter]);
            }
        }
    }
}
