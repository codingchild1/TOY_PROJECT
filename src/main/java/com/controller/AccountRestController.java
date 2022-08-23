package com.controller;

import com.dto.MberDate;
import com.service.AccountService;
import com.vo.AccountVO;
import com.vo.DateVO;
import com.vo.MberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("rest")
public class AccountRestController {

    @Autowired
    AccountService accountService;

    @RequestMapping("getlist")
    public List<AccountVO> getList(HttpSession session, DateVO dateVO) throws Exception {
        List<AccountVO> accList = new ArrayList<>();
        MberDate mberDate = new MberDate(); // 객체변수
        MberVO mberVO = (MberVO)session.getAttribute("vo"); // session에서 값 불러오기
        mberDate.setMberVO(mberVO); // 객체 mberDate 의 MberVO 안에 mberVO 값들 파라미터로 넣어주기
        mberDate.setDateVO(dateVO); // 객체 mberDate 의 DateVO 안에 mberVO 값들 파라미터로 넣어주기
        try {
            if (!dateVO.getMonth().equals("")) {
                dateVO.setMonth(String.format("%02d", Integer.parseInt(dateVO.getMonth())));
            }
            accList = accountService.selectAccountList(mberDate);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return accList;
    }

    @RequestMapping("insertlist")
    public String insertList(AccountVO accountVO) throws Exception {
        try {
            accountService.insertaccount(accountVO);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "false";
    }

    @RequestMapping("modifylist")
    public String updateList(AccountVO accountVO) throws Exception {
        try {
            accountService.updateAccount(accountVO);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "false";
    }

    @RequestMapping("accountaccnodata")
    public AccountVO selectAccountByAccNo(String accNo, Model model) throws Exception {
        AccountVO accountVO = new AccountVO();
        try {
            accountVO = accountService.selectAccountByAccNo(accNo);
            model.addAttribute("accNo", accNo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return accountVO;
    }

    @RequestMapping("accdelete")
    public AccountVO accDelete(AccountVO accountVO) throws Exception {
        try {
            accountService.deleteAccList(accountVO);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return accountVO;
    }
}
