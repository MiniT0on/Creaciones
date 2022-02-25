// Solo par labels
const Labels = {
    ["Una_Letra"]: document.getElementById('Una_Letra'),
    ["Resto_Letras"]: document.getElementById('Resto_Letras')
};

const DataList_OPCIONES = [ "Roblox Studio", "HTML", "Aplicaciones de escritorio",  ]

window.addEventListener('load', ()=>{
    // Colocando texto dentro de dos LABELS al cargar la ventana
    Labels["Una_Letra"].textContent = STRINGS.HTML.LabelsID.Una_Letra;
    Labels["Resto_Letras"].textContent = STRINGS.HTML.LabelsID.Resto_Letras;

    // Colocando opciones de busqueda en una DataList cuando la ventana cargue
    STRINGS.HTML.DataList.Buscar_SECCION.innerHTML = '';
    DataList_OPCIONES.forEach(elemento => {
        STRINGS.HTML.DataList.Buscar_SECCION.innerHTML += `<option value="${elemento}">`;
    })
});
