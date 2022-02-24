const Labels = {
    ["Una_Letra"]: document.getElementById('Una_Letra'),
    ["Resto_Letras"]: document.getElementById('Resto_Letras')
};

window.addEventListener('load', ()=>{
    Labels["Una_Letra"].textContent = STRINGS.HTML.LabelsID.Una_Letra;
    Labels["Resto_Letras"].textContent = STRINGS.HTML.LabelsID.Resto_Letras;
});

