export default {
    install(Vue) {
        // 指令 v-focus
        Vue.directive('focus', {
            inserted: function(el, binding) {
                if (binding.value) {
                    el.focus();
                } else {
                    el.blur();
                }
            },
            componentUpdated: function(el, binding) {
                if (binding.modifiers.lazy) {
                    if (Boolean(binding.value) === Boolean(binding.oldValue)) {
                        return;
                    }
                }
                if (binding.value) {
                    el.focus();
                } else {
                    el.blur();
                }
            },
        });
        Vue.directive('hide', function(el) {
            el.style.display = "none";
        });
        Vue.directive('hidden', function(el) {
            el.style.display = "none";
        });
        Vue.directive('single-line', function(el) {
            el.style.overflow = "hidden";
            el.style.whiteSpace = "nowrap";
            el.style.textOverflow = "ellipsis";
        });
    },
}