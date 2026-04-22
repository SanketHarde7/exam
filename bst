#include<stdio.h>
#include<stdlib.h>

struct Node {
    int data;
    struct Node *left, *right;
};

struct Node* insert(struct Node* root, int val) {
    if(root == NULL) {
        struct Node* n = (struct Node*)malloc(sizeof(struct Node));
        n->data = val; n->left = n->right = NULL;
        return n;
    }
    if(val < root->data) root->left  = insert(root->left, val);
    else                  root->right = insert(root->right, val);
    return root;
}

void inorder(struct Node* root) {
    if(root) { inorder(root->left); printf("%d ", root->data); inorder(root->right); }
}
void preorder(struct Node* root) {
    if(root) { printf("%d ", root->data); preorder(root->left); preorder(root->right); }
}
void postorder(struct Node* root) {
    if(root) { postorder(root->left); postorder(root->right); printf("%d ", root->data); }
}

int count(struct Node* root) {
    if(root == NULL) return 0;
    return 1 + count(root->left) + count(root->right);
}

int countLeaf(struct Node* root) {
    if(root == NULL) return 0;
    if(root->left == NULL && root->right == NULL) return 1;
    return countLeaf(root->left) + countLeaf(root->right);
}

int main() {
    struct Node *root = NULL;
    int ch, val;
    do {
        printf("\n1.Insert 2.Inorder 3.Preorder 4.Postorder 5.Count 6.CountLeaf 0.Exit\n");
        printf("Choice: "); scanf("%d", &ch);
        switch(ch) {
            case 1: printf("Value: "); scanf("%d",&val); root=insert(root,val); break;
            case 2: inorder(root);   printf("\n"); break;
            case 3: preorder(root);  printf("\n"); break;
            case 4: postorder(root); printf("\n"); break;
            case 5: printf("Total nodes: %d\n", count(root)); break;
            case 6: printf("Leaf nodes: %d\n", countLeaf(root)); break;
        }
    } while(ch != 0);
    return 0;
}
