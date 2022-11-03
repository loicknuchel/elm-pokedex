/** @type {import('tailwindcss').Config} */
module.exports = {
    content: ["./src/**/*.elm"],
    theme: {
        extend: {
            display: ["group-hover"]
        },
    },
    plugins: [
        require('@tailwindcss/forms')
    ],
}
