//variables
let cardBeignDragged;
let dropzones = document.querySelectorAll('.dropzone');
let priorities;
// let cards = document.querySelectorAll('.kanbanCard');

//list마다 색 지정
let dataColors = [
    {color:"yellow", title:"backlog"},
    {color:"green", title:"to do"},
    {color:"blue", title:"in progress"},
    {color:"purple", title:"testing"},
    {color:"red", title:"done"}
];
//key : @kanban:data
//value : {"config":{"maxid":0},"cards":[]}
let dataCards = {
    config:{
        maxid:0
    },
    cards:[] //카드는 여러장~ 배열~
};
let theme="light";


$(document).ready(()=>{ //document가 모두 로드된 후 실행
    $("#loadingScreen").addClass("d-none");
    theme = localStorage.getItem('@kanban:theme'); //@kanban:theme 를 불러와서 darkmode 썼는지 여부 확인
    if(theme){
        $("body").addClass(`${theme==="light"?"":"darkmode"}`); //삼항연산자로 theme 조정.
        //@kanban:theme로 불러온 theme값을 비교해서 하나봄
    }
    initializeBoards(); //보드만드는함수 실행 , 다크면 다크, 라이트면 라이트로 생성됨
    if(JSON.parse(localStorage.getItem('@kanban:data'))){
        //localStorage에 값이 이미 있으면 실행되고 아니면 null이 들어가서 실행안됨
        dataCards = JSON.parse(localStorage.getItem('@kanban:data'));
        initializeComponents(dataCards);
    }
    initializeCards();

	// 추가(sweet alert으로 약간 수정함)
    $('#add').click((e)=>{ // preventDefault 함수 적용시 event파라메터 필수
        e.preventDefault(); //클릭시 기본동작인 기능 작동을 중단시킴  (submit)
            const title = $('#titleInput').val()!=='' ? $('#titleInput').val() : null; //인풋태그 비어있으면 null
            const description = $('#descriptionInput').val()!=='' ? $('#descriptionInput').val()  : null; //얘도 삼항. 인풋태그 비어있으면 null
            const coloris = $('#selectbox').val()!=='선택하세요' ? $('#selectbox').val() : null;
            
            if(title && description && coloris){       //마찬가지로 둘중 하나라도 null이면 실행안됩니다.
                let id = dataCards.config.maxid+1; //id를 계속 1씩 늘려줘서 고유값 보존하기(PK)
                const newCard = {           //card 객체생성
                    id,
                    title,
                    description,
                    position: color,
                    priority: false  //별
                }
                dataCards.cards.push(newCard);  //dataCards 객체는 13번째 줄에서 틀을 만들어두었습니다. JSON객체로 구현하려고 저렇게했다네요 대견하죠
                dataCards.config.maxid = id; // 새로운 card객체가 생성되었으니 maxid도 갱신해줍니다.
                save();    // save()를 함수로 만들어두었음. localStorage.setItem('@kanban:data', JSON.stringify(dataCards)); 대충 로컬스토리지를 새롭게 덮어쓴다는 뜻ㅎ
                appendComponents(newCard); // 새로운카드는 append됨
                initializeCards(); //36번줄 ㄱㄱ

                $('#titleInput').val('');       //인풋 빈문자열로 변경 (setter)
                $('#descriptionInput').val(''); //인풋 빈문자열로 변경 (setter)
                $('#selectbox').val('선택하세요'); //초기화
            } else{
                add_alert(title, description, coloris);
            }
        });

    //선택한 type에 맞는 카드가 생성됨
    $('#selectbox').change(function(){ 
        let selectType = $(':selected').val();
        switch(selectType) {
            case "BACKLOG" : color = "yellow"; 
            break;
            case "TO DO" : color = "green"; 
            break;
            case "IN PROGRESS" : color = "blue"; 
            break;
            case "TESTING" : color = "purple"; 
            break; 
            case "DONE" : color = "red"; 
            break;
            case "선택하세요" : color = null;
            break;
        }
    });

    //dataCards = {config:{maxid:0}, cards:[]};
    $("#deleteAll").click(()=>{
        swal({
            title: "전체 삭제하시겠습니까?",
            text: "한번 삭제시 복구가 불가능합니다!",
            icon: "warning",
            buttons: true,
            dangerMode: true,
          })
          .then((willDelete) => {
            if (willDelete) {
             dataCards.cards = [];
                  save();
              
              swal("전체 삭제되었습니다!", {
                icon: "success",
                
              });
          setTimeout(function(){  // 시간제한 걸기 -> 왜 걸었음?
                                  // if문으로 들어가서 실행되는 순간 swal이 번쩍 하고 사라짐 그래서 시간지연 시켜줌
                location.reload(); // location의 객체 reload : 브라우저 창에 현재 문서를 다시 불러옴
          },1000);
            } else {
              swal("취소하였습니다!");
            }
          });
    });
    $("#theme-btn").click((e)=>{
        e.preventDefault(); //버튼 클릭시 발생하는 디폴트 함수 막음
        $("body").toggleClass("darkmode");
        if(theme){
            localStorage.setItem("@kanban:theme", `${theme==="light"?"darkmode":""}`)
        }
        else{
            localStorage.setItem("@kanban:theme", "darkmode")
        }
    });
});

////////////////////// functions //////////////////////
function initializeBoards(){
    dataColors.forEach(item=>{
        let htmlString = `
        <div class="board">
            <h3 class="text-center">${item.title.toUpperCase()}</h3>
            <div class="dropzone" id="${item.color}">

            </div>
        </div>
        `
        $("#boardsContainer").append(htmlString)
    });
    let dropzones = document.querySelectorAll('.dropzone');
    dropzones.forEach(dropzone=>{
        dropzone.addEventListener('dragenter', dragenter);
        dropzone.addEventListener('dragover', dragover);
        dropzone.addEventListener('dragleave', dragleave);
        dropzone.addEventListener('drop', drop);
    });
}

function initializeCards(){
    cards = document.querySelectorAll('.kanbanCard');

    cards.forEach(card=>{
        card.addEventListener('dragstart', dragstart);
        card.addEventListener('drag', drag);
        card.addEventListener('dragend', dragend);
    });
}

function initializeComponents(dataArray){
    //create all the stored cards and put inside of the todo area
    dataArray.cards.forEach(card=>{
        appendComponents(card);
    })
}

function appendComponents(card){
    //creates new card inside of the todo area
    let htmlString = `
        <div id=${card.id.toString()} class="kanbanCard ${card.position}" draggable="true">
            <div class="content">
                <h4 class="title">${card.title}</h4>
                <p class="description">${card.description}</p>
            </div>
            <form class="row mx-auto justify-content-between">
                <span id="span-${card.id.toString()}" onclick="togglePriority(event)" class="material-icons priority ${card.priority? "is-priority": ""}">
                    star
                </span>
                <button class="invisibleBtn">
                    <span class="material-icons delete" onclick="deleteCard(${card.id.toString()})">
                        remove_circle
                    </span>
                </button>
            </form>
        </div>
    `
    $(`#${card.position}`).append(htmlString);
    priorities = document.querySelectorAll(".priority");
}

//카드에 별표시 기능
function togglePriority(event){
    event.target.classList.toggle("is-priority");
    dataCards.cards.forEach(card=>{ //card를 parameter로 받는다
        console.log(card);
        //console.log(event.target.id); span-23
        //console.log(card.id.toString()); 23 
        if(event.target.id.split('-')[1] === card.id.toString()){
            card.priority = card.priority?false:true; 
        }
    })
    save();
}

//카드 삭제
function deleteCard(id){
    dataCards.cards.forEach(card=>{
        if(card.id === id){
            let index = dataCards.cards.indexOf(card);
            dataCards.cards.splice(index, 1);
            save();
        }
    })
}

function removeClasses(cardBeignDragged, color){
    cardBeignDragged.classList.remove('red');
    cardBeignDragged.classList.remove('blue');
    cardBeignDragged.classList.remove('purple');
    cardBeignDragged.classList.remove('green');
    cardBeignDragged.classList.remove('yellow');
    cardBeignDragged.classList.add(color);
    position(cardBeignDragged, color);
}

function save(){
    //localStorage는 js내장함수
    //JSON.stringify >> 객체 데이터를 문자열 데이터로 변경
    //localStorage는 무조건 string으로 저장시키기 때문에 stringify해서 저장한다
    localStorage.setItem('@kanban:data', JSON.stringify(dataCards));
}

function position(cardBeignDragged, color){
    const index = dataCards.cards.findIndex(card => card.id === parseInt(cardBeignDragged.id));
    dataCards.cards[index].position = color;
    save();
}

 // 추가하기 sweet alert
function add_alert(title, description, coloris){
	swal("입력되지 않은 항목이 있습니다.", "", "error")
.then((result) => {
    result = '';
    if(!coloris){
        result += 'Type ';
    }
    if(!title){
        result += 'Title ';
    }
    if(!description){
        result += 'Description ';
    }
    swal(
        '아래 항목을 입력해 주세요',
        `${result}`,
        'info'
      )
});
}

////////////////////// cards event //////////////////////
function dragstart(){
    dropzones.forEach( dropzone=>dropzone.classList.add('highlight'));
    this.classList.add('is-dragging');
}

function drag(){

}

function dragend(){
    dropzones.forEach( dropzone=>dropzone.classList.remove('highlight'));
    this.classList.remove('is-dragging');
}

// Release cards area
function dragenter(){

}

function dragover({target}){
    this.classList.add('over');
    cardBeignDragged = document.querySelector('.is-dragging');
    if(this.id ==="yellow"){
        removeClasses(cardBeignDragged, "yellow");
    }
    else if(this.id ==="green"){
        removeClasses(cardBeignDragged, "green");
    }
    else if(this.id ==="blue"){
        removeClasses(cardBeignDragged, "blue");
    }
    else if(this.id ==="purple"){
        removeClasses(cardBeignDragged, "purple");
    }
    else if(this.id ==="red"){
        removeClasses(cardBeignDragged, "red");
    }

    this.appendChild(cardBeignDragged);
}

function dragleave(){
    this.classList.remove('over');
}

function drop(){
    this.classList.remove('over');
}
