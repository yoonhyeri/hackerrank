import java.util.Arrays;

class Solution {
    public boolean solution(String[] phone_book) {
        boolean answer = true;
        
        // 전화번호를 사전순으로 정렬
        Arrays.sort(phone_book);
        
        for(int i=0; i<phone_book.length-1; i++ ){
            if(phone_book[i+1].startsWith(phone_book[i])){
                return false;
            }
            
        }
        
        
        return true;
    }
}